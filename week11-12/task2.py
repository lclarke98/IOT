import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn.metrics import confusion_matrix
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.cluster import KMeans as km

def confusionM(y_true,y_predict,target_names):
    cMatrix = confusion_matrix(y_true,y_predict)
    df_cm = pd.DataFrame(cMatrix,index=target_names,columns=target_names)
    plt.figure(figsize = (6,4))
    cm = sns.heatmap(df_cm,annot=True,fmt="d")
    cm.yaxis.set_ticklabels(cm.yaxis.get_ticklabels(),rotation=90)
    cm.xaxis.set_ticklabels(cm.xaxis.get_ticklabels(),rotation=0)
    plt.ylabel('True label')
    plt.xlabel('Predicted label')

def convertCluster2Label(cluster_labels,original_labels,labels2convert):
    converted_labels =np.full(labels2convert.size, -1)
    for i in np.unique(cluster_labels):
        temp_original_labels = original_labels[cluster_labels==i]
        temp_label = np.bincount(temp_original_labels).argmax()
        converted_labels[labels2convert==i] = temp_label
    return converted_labels
        

iris = datasets.load_iris()
X = iris.data
y = iris.target
target_names = iris.target_names
X_train, X_test, y_train, y_true = train_test_split(X, y)
kmeans = km(n_clusters=3, n_init=2020)
kmeans.fit(X_train)
values = kmeans.cluster_centers_.squeeze()
trained_labels = kmeans.labels_
labels_predict = kmeans.predict(X_test)
print(labels_predict)
y_predict = convertCluster2Label(trained_labels,y_train,labels_predict)
print(y_predict)

confusionM(y_true,y_predict,target_names)