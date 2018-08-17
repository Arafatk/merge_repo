$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

# Include Paths
require 'rubyplot'
require 'data_array'
require 'bar/bar_gen'
require 'dot/dot_gen'
require 'line/line_gen'
require 'scatter/scatter_gen'
require 'bubble/bubble_gen'
require 'stacked_bar/stacked_gen'

def compare_with_reference?(test_image, reference_image, tolerance)
  compute_rms(test_image, reference_image) < tolerance
end

# Computes the RMS value between two images
def compute_rms(test_image, reference_image)
  image1 = Magick::Image.read(('spec/reference_images/' + test_image)).first
  image2 = Magick::Image.read(('spec/reference_images/' + reference_image)).first
  diff = 0
  pixel_array_1 = image1.export_pixels
  pixel_array_2 = image2.export_pixels
  for i in 0..(pixel_array_1.size - 1)
    diff += ((pixel_array_1[i] - pixel_array_2[i]).abs / 3)**2
  end
  Math.sqrt(diff / (512 * 512))
end
