# Linting as a Service
This image provides a simple server running [shellcheck](https://github.com/koalaman/shellcheck).

# Usage

### build docker container
`docker build -t ohaddahan/linter:latest .`

### or pull docker container
`docker pull ohaddahan/linter:latest`

### start docker container
`docker run -d -p 3000:3000 ohaddahan/linter:latest`

### stop all running containers of this image
`docker stop $(docker ps | \grep ohaddahan/linter:latest | awk '{print $1}')`

### Log into running docker container
`docker exec -it <CONTAINER_ID> "/bin/sh"`

### Request Structure
```json
{
  "script": "script content",
  "type": "sh | bash | dash | ksh"
}
```

### Response Structure
```json
{
  "status": "fail | success",
  "message": "Error message",
  "shellCheckResults": [lintResults]
}
```


### Server Usage

#### No lint issues request
```shell script
    curl \
        -X POST \
        -d '{ "type": "sh" , "script": "echo 123" }' \
        -H "Content-Type: application/json" \
        127.0.0.1:3000/check
```

#### No lint issues response

```json
{
  "status":"success",
  "shellCheckResults":[]
}
```

#### Lint issues request
```shell script
  curl \
    -X POST \
    -d '{ "type": "sh" , "script": "if [ '1' = '2' ] ; then \n echo 2 \n fi" }' \
    -H "Content-Type: application/json" \
    127.0.0.1:3000/check
```

#### Lint issues response

```json
{
  "status":"success",
  "shellCheckResults":[
      {
        "file":"tmpFiles/1946.sh",
        "line":1,
        "endLine":1,
        "column":8,
        "endColumn":9,
        "level":"warning",
        "code":2050,
        "message":"This expression is constant. Did you forget the $ on a variable?",
        "fix":null
      }
  ]
}
```


