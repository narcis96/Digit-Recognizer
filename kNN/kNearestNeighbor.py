import math
import csv
import random
import math
import operator
from numpy import linalg
from scipy.spatial import distance
class kNearestNeighbor(object):

    def __init__(self, trainData, trainLabels, k):
        self.__trainData = trainData
        self.__trainLabels = trainLabels
        self.__k = k
        self.Split()
        self.__CrossValidation()

    def getNeighbors(self, testInstance):
        neighbors = []
        distances = []
        length = len(testInstance)
        for x in range(len(self.__trainData)):
            #dist = numpy.linalg.norm(testInstance - trainingSet[x])
            dist = distance.euclidean(testInstance, self.__trainData[x])
            distances.append((self.__trainData[x], dist))
        distances.sort(key=operator.itemgetter(1))
        for x in range(self.__k):
            neighbors.append(distances[x][0])
        return neighbors;

    def __Split(self):


    def __CrossValidation(self):


    def predict(self, ):



if __name__ == "__main__":
    print (1)