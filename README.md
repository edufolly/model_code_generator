# Model Code Generator

A model generator to use
with [FollyFields](https://github.com/edufolly/folly_fields).

## Getting Started

JSON examples:

### Company

```json
{
  "name": "Company",
  "languageType": "Dart",
  "packagePath": "my_app/models",
  "attributes": [
    {
      "name": "active",
      "type": "Boolean",
      "nullAware": "true"
    },
    {
      "name": "cnpj",
      "type": "String"
    },
    {
      "name": "companyName",
      "type": "String"
    },
    {
      "name": "tradeName",
      "type": "String"
    }
  ],
  "searchTerm": "tradeName",
  "toString": "tradeName"
}
```

### User

```json
{
  "name": "User",
  "languageType": "Dart",
  "packagePath": "my_app/models",
  "attributes": [
    {
      "name": "active",
      "type": "Boolean",
      "nullAware": "true"
    },
    {
      "name": "companies",
      "type": "List",
      "internalName": "Company",
      "internalType": "Model"
    },
    {
      "name": "email",
      "type": "String"
    },
    {
      "name": "forceResetPassword",
      "type": "Boolean",
      "nullAware": "false"
    },
    {
      "name": "name",
      "type": "String"
    },
    {
      "name": "pass",
      "type": "String"
    }
  ],
  "searchTerm": "email",
  "toString": "email"
}
```