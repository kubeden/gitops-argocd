(import '../params.libsonnet'){
    
    name: 'hello-world-backend',

    docker: {
        image: '//some registry/hello-world-backend',  
    },

    containerPort: 8080,

    autoscale: {
        enabled: false,
    },
    
    replicas: 1,

    //These are used to have someobody to contact about the application.
    contact: 'dennis@denctl.com',
}