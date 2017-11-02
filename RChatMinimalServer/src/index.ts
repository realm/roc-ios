import { BasicServer } from 'realm-object-server'
import * as path from 'path'

const server = new BasicServer()
var theRealm: Realm = null;
const RealmName = "RC-Global";

    console.log(`Directory is ${__dirname}`);
    server.start({
    // This is the location where ROS will store its runtime data
    httpsAddress: "0.0.0.0",
    dataPath: path.join(__dirname, '../data')
    
        // The address on which to listen for connections
        // Default: 0.0.0.0
        // address?: string
        
        // The port on which to listen for connections
        // Default: 9080
        // port?: number
    
        // Override the default list of authentication providers
        // authProviders?: IAuthProvider[]
    
        // Autogenerate public and private keys on startup
        // autoKeyGen?: boolean
    
        // Specify an alternative path to the private key. Otherwise, it is expected to be under the data path.
        // privateKeyPath?: string 
    
        // Specify an alternative path to the public key. Otherwise, it is expected to be under the data path.
        // publicKeyPath?: string
    
        // The desired logging threshold. Can be one of: all, trace, debug, detail, info, warn, error, fatal, off)
        // Default: info
        // logLevel?: string
    
        // Enable the HTTPS Server.
        // https?: boolean
    
        // The port on which to listen for HTTPS connections.
        // Default: 0.0.0.0
        // httpsAddress?: string
    
        // The address on which to listen for HTTPS connections.
        // Default: 9443
        // httpsPort?: number
    
        // The path to your HTTPS private key in PEM format. Required if HTTPS is enabled.
        // httpsKeyPath?: string
    
        // The path to your HTTPS certificate chain in PEM format. Required if HTTPS is enabled.
        // httpsCertChainPath?: string
    
        // Specify the length of time (in seconds) in which access tokens are valid.
        // Default: 600 (ten minutes)
        // accessTokenTtl?: number
    
        // Specify the length of time (in seconds) in which refresh tokens are valid.
        // Default: 3153600000 (ten years)
        // refreshTokenTtl?: number
    })
        .then(() => {
            console.log(`Your server is started `, server.address);
            return Realm.Sync.User.login('http://localhost:9080', 'realm-admin', '');
        })
        .then((user) => {
            return Realm.open({
                sync: {
                    user: user,
                    url: `realm://localhost:9080/${RealmName}`
                },
                schema: [],
            });
    
        })
        .then(realm => {
            theRealm = realm;
            // if your app has options - maybe to load sample data, or run in a
            // specialized mode, could proess them here:
            processCommandLineOptions();
        })
        .catch(err => {
            console.error(`There was an error starting your file`, err);
        });
    


function processCommandLineOptions() {
    // let param = process.argv[2]; // Gets the first token after the `node index.js`
    // if ((typeof param != 'undefined') && param == "--load-sample-data") {
    //     if (theRealm.objects(PersonSchema.name).length > 0 || fs.existsSync(dataLoadedFilePath) == true) {
    //         console.log("Data already loaded... skipping.")
    //         return;
    //     } else {
    //         // do someting here - for example: loadSampleData();
    //     }
    // } // check command line params     
} // of processCommandLineOptions
