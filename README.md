# rust_x_azure

# Operation on Azure

## 1. register app

```shell
appId=$(az ad app create --display-name example-app-name --query appId -o tsv)
```

## 2. create service principal

```shell
spObjectId=$(az ad sp create --id $appId --query id -o tsv)
```

## 3. Assign ACRPush role to the service principal

```shell
acrId=$(az acr show -n $acrName --query id -o tsv)
az role assignment create --role ACRPush  --asignee $spObjectId --scope $acrId
```

## 4. Assign contributor role of ACA to the service principal

```shell
az role assignment create --role Contributor --asignee $spObjectId --scope $acrId
```

## 5. Create OpenID Connect Federation Info file temporarily

```JSON
{
    "name": "github_federation_for_container_apps",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:[GitHub user name or organization name]/[repository-name]:ref:refs/heads/main",
    "audiences": [
        "api://AzureADTokenExchange"
    ]
}
```

## 6. create the credential of Open-ID Federation with the above json file

```shell
az ad app federated-credential create --id $appId --parameters credential.json
```
