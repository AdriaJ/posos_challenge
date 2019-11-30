import pandas as pd
import numpy as np
import os

from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import svm

from sklearn.metrics import precision_recall_fscore_support
from sklearn.metrics import confusion_matrix

from joblib import dump, load

volume_path = "/app"
in_train_path = os.path.join(volume_path, 'data/input_train.csv')
out_train_path = os.path.join(volume_path, 'data/output_train.csv')
# read data
X = pd.read_csv(in_train_path, index_col=0)
y = pd.read_csv(out_train_path, index_col=0)

X_train, X_val, y_train, y_val = train_test_split(X, y, train_size=.8)

print("Training model ...")

# vectorize
vectorizer = TfidfVectorizer()

X_train_v = vectorizer.fit_transform(X_train["question"])

# classifier
clf = svm.SVC(gamma='scale')
clf.fit(X_train_v, y_train['intention'].to_numpy())

print("Done training!")

# Evaluating the model :
X_val_v = vectorizer.transform(X_val['question'])
y_val_pred = clf.predict(X_val_v)

# print("Precision - Recall - F1-Score (over validation set):")
# print("Macro:")
# print(precision_recall_fscore_support(y_val.to_numpy().reshape(-1,), y_val_pred, average='macro')[:3])
# print("Micro:")
# print(precision_recall_fscore_support(y_val.to_numpy().reshape(-1,), y_val_pred, average='micro')[:3])
#
# print("Confusion matrix (over validation set):")
# cm = confusion_matrix(y_val.to_numpy().reshape(-1,), y_val_pred)
# print(cm)


# exporting the model


export_path = os.path.join(volume_path, "model_svm")
print('Exporting trained model to', export_path)
dump(clf, export_path)
print("Done exporting!")
