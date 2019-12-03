# posos_challenge
Application project for Posos - see https://github.com/VincentMatthys/posos_sample

## How to use this repo ?

__Prerequisite__
Build and tested to run under unix-like system.
You should be able to run docker without being rooot user (without `sudo`)

__What to do?__

* Clone the files and set the repo as the current working directory.
```
git clone https://github.com/AdriaJ/posos_challenge.git
cd posos_challenge
```

* Train the model and run the api (*You must know the passphrase to decrypt the data.*)

```
make train
make api
```
> It will create a folder called `models` which contains the trained model and vectorizer from the first docker. You will also see the untar decrypted data in the `data` folder.

* Try the microservice with any query you want
```
curl -G "http://localhost:4002/intent" --data-urlencode "query=risques poisson cru pendant la grossesse ?" | jq
```


