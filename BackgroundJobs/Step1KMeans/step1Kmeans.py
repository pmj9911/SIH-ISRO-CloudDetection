# '''
# File: _KMeans Cloud Detection.py_

# Requirements: numpy, opencv, matplotlib

# Input:
# image_folder (string): Specify path to image
# timestamp (string): Image name without extension (Reads in png by default)

# Output:
# cloud_detection (dictionary): Key is cloud number and value is a dictionary with timestamp, cloud_no, algorithm, centroidX and centroidY for that cloud.'''

# Importing Libraries
import numpy as np
import cv2
import rasterio
import matplotlib.pyplot as plt


def step1Kmeans(imagePath, output_folder):
    img = cv2.imread(imagePath)
    Z = img.reshape((-1,3))

    # convert to np.float32
    Z = np.float32(Z)

    # define criteria, number of clusters(K) and apply kmeans()
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
    K = 4
    ret, label,center=cv2.kmeans(Z,K,None,criteria,10,cv2.KMEANS_RANDOM_CENTERS)

    # Now convert back into uint8, and make original image
    center = np.uint8(center)
    res = center[label.flatten()]
    res2 = res.reshape((img.shape))
    res2bw = cv2.cvtColor(res2, cv2.COLOR_BGR2GRAY)
    colors = np.unique(res2bw)

    # Plotting grayscale masks
    #plt.imshow(res2bw, cmap = 'gray')
    #plt.colorbar()
    #plt.show()

    cv2.imwrite(output_folder + imagePath[-15:], res2bw)
    # Removing background, since the darkest color is sky
    colors = colors[1:]
    #print(colors)

    # Processing every cloud
    cloud_detection = {}
    for i in range(0, len(colors)):
        filter_mask = (res2bw == colors[i]).astype(int)
        filter_mask = cv2.convertScaleAbs(filter_mask, alpha=(255.0))
        co_ordinates = np.where(filter_mask == 0)
        x = co_ordinates[0]
        y = co_ordinates[1]
        mean_x = np.mean(x)
        mean_y = np.mean(y)
        cloud_detection[str(i)] = {'cloud_no': i, 
                                'com_x': mean_x, 
                                'com_y': mean_y}


    # Print cloud detection output
    print(cloud_detection)
    return cloud_detection

# image_folder = './images/'
# timestamp = '2'
# file_type = 'png'
# output_folder = './output/'
# kmeans_cloud_detection(image_folder, timestamp, file_type, output_folder)