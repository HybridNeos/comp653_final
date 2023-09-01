import pyspark.pandas as ps
import pandas as pd

from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier

from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.metrics import accuracy_score, roc_auc_score, f1_score

def model(dbt, session):
    # dbt.config(
    #     submission_method="serverless",
    #     gcs_bucket="mark-dbt-learn-bucket",
    #     dataproc_region="us-east1"
    # )
    return dbt.ref("train_data")