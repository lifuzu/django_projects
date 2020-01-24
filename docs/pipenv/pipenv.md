### Sync up the dependencies
```
$ pipenv sync
```

### Create requirements.txt
```
$ pipenv lock -r > requirements.txt
```
OR
```
$ jq -r '.default
        | to_entries[]
        | .key + .value.version' \
        Pipfile.lock > requirements.txt
```
