import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from sklearn.metrics import confusion_matrix
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

def confusionM(y_true,y_predict,target_names):
    cMatrix = confusion_matrix(y_true,y_predict)
    df_cm = pd.DataFrame(cMatrix,index=target_names,columns=target_names)
    plt.figure(figsize = (6,4))
    cm = sns.heatmap(df_cm,annot=True,fmt="d")
    cm.yaxis.set_ticklabels(cm.yaxis.get_ticklabels(),rotation=90)
    cm.xaxis.set_ticklabels(cm.xaxis.get_ticklabels(),rotation=0)
    plt.ylabel('True label')
    plt.xlabel('Predicted label')


iris = datasets.load_iris()
X = iris.data
y = iris.target
target_names = iris.target_names

digits = datasets.load_digits()
digitsx = digits.data
X = digits.data
y = digits.target
target_names = digits.target_names


X_train, X_test, y_train, y_true = train_test_split(X, y)
nn = KNeighborsClassifier(n_neighbors=1)
nn.fit(X_train,y_train)
y_predict = nn.predict(X_test)
print(y_predict)
print(nn.score(X_test,y_true))

confusionM(y_true,y_predict,target_names)