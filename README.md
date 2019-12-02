# posos_challenge
Application project for Posos - see https://github.com/VincentMatthys/posos_sample

## How to use this repo ?

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

* Try the microservice with any query you want
```
curl -G "http://localhost:4002/intent" --data-urlencode "query=risques poisson cru pendant la grossesse ?" | jq
```


