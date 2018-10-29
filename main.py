# Imports
import keras.backend as K
from keras.applications import VGG16

from PIL import Image # This is actually installed using `pip install Pillow`

import numpy as np
import time

from scipy.optimize import fmin_l_bfgs_b
from scipy.misc import imsave

import argparse

"""
Code for style, content, and variation loss is from https://github.com/hunter-heidenreich/ML-Open-Source-Implementations/blob/master/Style-Transfer/Style%20Transfer.ipynb
(Also the code for the evaluator class is from that link)
"""


# Content loss
def content_loss(content_features, generated_features):
    return 0.5 * K.sum(K.square(generated_features - content_features))


def gram_matrix(features):
    return K.dot(features, K.transpose(features))


def style_loss(style_matrix, generated_matrix):
    # Permute the matrix to calculate proper covariance
    style_features = K.batch_flatten(K.permute_dimensions(style_matrix, (2, 0, 1)))
    generated_features = K.batch_flatten(K.permute_dimensions(generated_matrix, (2, 0, 1)))

    # Get the gram matrices
    style_mat = gram_matrix(style_features)
    generated_mat = gram_matrix(generated_features)

    return K.sum(K.square(style_mat - generated_mat)) / (4.0 * (img_channels ** 2) * (img_size ** 2))


#Variation loss (reduce pixel noise)
def variation_loss(generated_matrix):
    a = K.square(generated_matrix[:, :img_height-1, :img_width-1, :] - generated_matrix[:, 1:, :img_width-1, :])
    b = K.square(generated_matrix[:, :img_height-1, :img_width-1, :] - generated_matrix[:, :img_height-1, 1:, :])

    return K.sum(K.pow(a + b, 1.25))


def total_loss(c_layer, s_layers, generated, content_weight=0.025, style_weight=1.0, variation_weight=1.0):
    """
    Standard weight values: (These are just values that
    I've found to work, there might be better values)

    content_weight = 0.025
    style_weight = 1.0
    variation_weight = 1.0
    """
    # Content loss
    content_features = c_layer[CONTENT_IMAGE_POS, :, :, :]
    generated_features = c_layer[GENERATED_IMAGE_POS, :, :, :]
    c_loss = content_loss(content_features, generated_features)

    # Style loss
    s_loss = None
    for layer in s_layers:
        style_features = layer[STYLE_IMAGE_POS, :, :, :]
        generated_features = layer[GENERATED_IMAGE_POS, :, :, :]
        if s_loss is None:
            s_loss = style_loss(style_features, generated_features) * (style_weight / len(s_layers))
        else:
            s_loss += style_loss(style_features, generated_features) * (style_weight / len(s_layers))

    # Variation loss (for regularization)
    v_loss = variation_loss(generated)

    return content_weight * c_loss + s_loss + variation_weight * v_loss


# Returns the content and style layers we will need for style transfer
def get_layers(content_matrix, style_matrix, generated_matrix):
    # Prep the model for our new input sizes
    input_tensor = K.concatenate([content_matrix, style_matrix, generated_matrix], axis=0)
    model = VGG16(input_tensor=input_tensor, weights='imagenet', include_top=False)

    # Convert layers to dictionary
    layers = dict([(layer.name, layer.output) for layer in model.layers])

    # Pull the specific layers we want
    c_layers = layers['block2_conv2']
    s_layers = ['block1_conv2', 'block2_conv2', 'block3_conv3', 'block4_conv3', 'block5_conv3']
    s_layers = [layers[layer] for layer in s_layers]

    return c_layers, s_layers


# Function for processing image, returns numpy
def process_img(path):
    # Open image and resize it
    img = Image.open(path)
    img = img.resize((img_width, img_height))

    # Convert image to data array
    data = np.asarray(img, dtype='float32')
    data = np.expand_dims(data, axis=0)
    data = data[:, :, :, :3]

    # Flip from RGB to BGR
    data = data[:, :, :, ::-1]

    return data


# Saves an image with the given file name
def save_image(filename, generated):

    # Reshape image and flip from BGR to RGB
    generated = generated.reshape((img_height, img_width, 3))
    generated = generated[:, :, ::-1]

    # Clip values to 0-255
    generated = np.clip(generated, 0, 255).astype('uint8')

    imsave(filename, Image.fromarray(generated))

# Change style so that it has the image mean pixel values (BGR)
# (this prevents the output image to change colors)
def update_style(content, style):
    # Find content mean values
    c_blue_vals = content[:, :, :, 0]
    c_green_vals = content[:, :, :, 1]
    c_red_vals = content[:, :, :, 2]
    c_b_mean = np.mean(c_blue_vals)
    c_g_mean = np.mean(c_green_vals)
    c_r_mean = np.mean(c_red_vals)

    # Find style mean values
    s_blue_vals = style[:, :, :, 0]
    s_green_vals = style[:, :, :, 1]
    s_red_vals = style[:, :, :, 2]
    s_b_mean = np.mean(s_blue_vals)
    s_g_mean = np.mean(s_green_vals)
    s_r_mean = np.mean(s_red_vals)
    b_diff = c_b_mean - s_b_mean
    g_diff = c_g_mean - s_g_mean
    r_diff = c_r_mean - s_r_mean

    style[:, :, :, 0] += b_diff
    style[:, :, :, 1] += g_diff
    style[:, :, :, 2] += r_diff
    return style


# Evaluator class used to track gradients and loss values
class Evaluator(object):

    def __init__(self):
        self.loss_value = None
        self.grad_values = None

    def loss(self, x):
        assert self.loss_value is None
        loss_value, grad_values = eval_loss_and_grads(x)
        self.loss_value = loss_value
        self.grad_values = grad_values
        return self.loss_value

    def grads(self, x):
        assert self.loss_value is not None
        grad_values = np.copy(self.grad_values)
        self.loss_value = None
        self.grad_values = None
        return grad_values


# Computes loss and gradients
def eval_loss_and_grads(generated):
    generated = generated.reshape((1, img_height, img_width, 3))
    outs = f_outputs([generated])
    loss_value = outs[0]
    grad_values = outs[1].flatten().astype('float64')
    return loss_value, grad_values


# Arguments
parser = argparse.ArgumentParser(description='Sycamore Style Transfer')
parser.add_argument('content_img', metavar='content_img', type=str, help='Path to target content image')
parser.add_argument('style_img', metavar='style_img', type=str, help='Path to target style image')
parser.add_argument('result_img', metavar='result_img', type=str, help='Path where new generated image is saved')
parser.add_argument('--iter', type=int, default=9, required=False, help='Number of iterations to run')
parser.add_argument('--height', type=int, default=512, required=False, help='Height of the input image')
parser.add_argument('--width', type=int, default=512, required=False, help='Width of the input image')

args = parser.parse_args()
# Params #
img_height = args.height
img_width = args.width
img_size = img_height * img_width
img_channels = 3

content_path = args.content_img
style_path = args.style_img
target_path = args.result_img

CONTENT_IMAGE_POS = 0
STYLE_IMAGE_POS = 1
GENERATED_IMAGE_POS = 2

# Main function
if __name__ == '__main__':
    # Prepare the generated image
    generated_img = np.random.uniform(0, 255, (1, img_height, img_width, 3))

    # Load the respective content and style images
    content = process_img(content_path)
    style = process_img(style_path)

    # Prepare the variables for the flow graph
    content_image = K.variable(content)
    style_image = K.variable(style)
    generated_image = K.placeholder((1, img_height, img_width, 3))
    loss = K.variable(0.)

    # Grab the layers needed to prepare the loss metric
    content_layer, style_layers = get_layers(content_image, style_image, generated_image)

    # Define loss and gradient
    loss = total_loss(content_layer, style_layers, generated_image)
    grads = K.gradients(loss, generated_image)

    # Define the output
    outputs = [loss]
    outputs += grads
    f_outputs = K.function([generated_image], outputs)

    evaluator = Evaluator()
    iterations = args.iter

    name = target_path
    save_image(name, generated_img)

    for i in range(iterations):
        print('Iteration:', i)
        start_time = time.time()
        generated_img, min_val, info = fmin_l_bfgs_b(evaluator.loss, generated_img.flatten(),
                                                     fprime=evaluator.grads, maxfun=20)
        print('Loss:', min_val)
        end_time = time.time()
        print('Iteration {} took {} seconds'.format(i, end_time - start_time))
        save_image(name, generated_img)
        print('Saved image to: {}'.format(name))