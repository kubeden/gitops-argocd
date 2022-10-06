(import '../params.libsonnet'){
    
    name: 'hello-world-frontend',

    docker: {
        image: '//somecontainer-registry-on-do'  
    },

    containerPort: 80,

    autoscale: {
        enabled: false,
    },
    
    replicas: 2,

    //These are used to have someobody to contact about the application.
    contact: 'dennis@denctl.com',
}