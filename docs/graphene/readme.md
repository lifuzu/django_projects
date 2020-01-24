
### Create ingredients app
```
django-admin.py startapp ingredients
```

### Verify the changes:
```
# Open a brower pointing to localhost:8000/graphql
query {
  allIngredients {
    id
    name
    category {
      id
      name
    }
  }
}
# OR
query {
  allCategories {
    id
    name
    ingredients {
      id
      name
    }
  }
}
```


### Following the instruction:
https://docs.graphene-python.org/projects/django/en/latest/tutorial-plain/
