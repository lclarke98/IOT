from sklearn.model_selection import train_test_split
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.metrics import confusion_matrix
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import datasets


iris = datasets.load_iris()
print(iris)
irisx = iris.data
print(irisx.shape)
irisy = iris.target
print(irisx.shape)

digits = datasets.load_digits()
print(digits)
digitsx = digits.data
print(digitsx.shape)

digitsy = digits.target
print(digitsy.shape)

plt.gray()
plt.matshow(digits.images[990])

plt.show()


def confusionM(y_true, y_predict, target_names):

    cMatrix = confusion_matrix(y_true, y_predict)
    df_cm = pd.DataFrame(cMatrix, index=target_names, columns=target_names)
    plt.figure(figsize=(6, 4))
    cm = sns.heatmap(df_cm, annot=True, fmt="d")
    cm.yaxis.set_ticklabels(cm.yaxis.get_ticklabels(), rotation=90)
    cm.xaxis.set_ticklabels(cm.xaxis.get_ticklabels(), rotation=0)
    plt.ylabel('True label')
    plt.xlabel('Predicted label')


iris = datasets.load_iris()
X = iris.data
y = iris.target
target_names = iris.target_names
X_train, X_test, y_train, y_true = train_test_split(X, y)
lda = LinearDiscriminantAnalysis()
lda.fit(X_train, y_train)
y_predict = lda.predict(X_test)

confusionM(y_true, y_predict, target_names)
