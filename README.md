# keymaster

:key: *OpenSSL convenience scripts*

This is a Docker container that can be used to generate a closed network of TLS credentials, suitable for use among sets of microservices that only need to (and only *should*) communicate among themselves.

## To Use

 1. You'll need a directory to store input and output.

    ```bash
    mkdir certificates
    ```

 1. Generate a password and store it in a file called `password` within that directory.

    ```bash
    touch certificates/password
    chmod 600 certificates/password
    cat /dev/random | head -c 128 | base64 > certificates/password
    ```

 1. Run the container with different commands to create a certificate authority, signed keypairs or self-signed keypairs. You'll need to mount your input/output directory to the path `/certificates` within the container.

    ```bash
    KEYMASTER="docker run --rm -v $(pwd)/certificates/:/certificates/ cloudpipe/keymaster"

    # Certificate authority
    # certificates/ca.pem and certificates/ca-key.pem
    ${KEYMASTER} ca

    # Signed client keypair for "service1.host.com"
    # certificates/service1-cert.pem and certificates/service1-key.pem
    ${KEYMASTER} signed-keypair -n service1 -h service1.host.com

    # Signed server keypair for "service2.host.com"
    # certificates/service2-cert.pem and certificates/service2-key.pem
    ${KEYMASTER} signed-keypair -n service2 -h service2.host.com -p server

    # Self-signed credentials for development of externally-facing parts
    # certificates/external-cert.pem and certificates/external-key.pem
    ${KEYMASTER} selfsigned-keypair -n external
    ```
