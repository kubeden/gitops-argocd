(import '../params.libsonnet'){
    
    name: 'hello-world-backend',

    docker: {
        image: 'registry.digitalocean.com/denctl'
    },

    containerPort: 3001,

    autoscale: {
        enabled: false,
    },
    
    replicas: 1,

    //These are used to have someobody to contact about the application.
    contact: 'denctl',
}