# Model Code Generator

A model generator to use
with [FollyFields](https://github.com/edufolly/folly_fields).

:star: to support the project.

## Web App

https://edufolly.github.io/model_code_generator/

## Getting Started

JSON examples:

### Company

```json
{
  "name": "Company",
  "languageType": "Dart",
  "packagePath": "my_app/models",
  "idType": "Integer",
  "attributes": [
    {
      "name": "active",
      "type": "Boolean",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": "true"
    },
    {
      "name": "cnpj",
      "type": "String",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": ""
    },
    {
      "name": "companyName",
      "type": "String",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": ""
    },
    {
      "name": "tradeName",
      "type": "String",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": ""
    }
  ],
  "searchTerm": "tradeName",
  "toString": "tradeName",
  "moreCode": ""
}
```

### User

```json
{
  "name": "User",
  "languageType": "Dart",
  "packagePath": "my_app/models",
  "idType": "Integer",
  "attributes": [
    {
      "name": "active",
      "type": "Boolean",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": "true"
    },
    {
      "name": "companies",
      "type": "List",
      "internalType": "Model",
      "internalName": "Company",
      "nullAware": ""
    },
    {
      "name": "email",
      "type": "String",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": ""
    },
    {
      "name": "forceResetPassword",
      "type": "Boolean",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": "false"
    },
    {
      "name": "name",
      "type": "String",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": ""
    },
    {
      "name": "pass",
      "type": "String",
      "internalType": "Empty",
      "internalName": "",
      "nullAware": ""
    }
  ],
  "searchTerm": "email",
  "toString": "email",
  "moreCode": ""
}
```