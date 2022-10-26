(import '../params.libsonnet'){
    
    name: 'demo-world-frontend',

    docker: {
        image: 'registry.digitalocean.com/denctl'  
    },

    containerPort: 80,

    autoscale: {
        enabled: false,
    },
    
    replicas: 1,

    //These are used to have someobody to contact about the application.
    contact: 'denctl',
}