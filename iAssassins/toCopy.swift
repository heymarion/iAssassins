func makeGame(gameid: String) {
    var ref = new Firebase("https://vivid-torch-6580.firebaseio.com/");
    gameRef = ref.childByAppendingPath(gameid);
    var gameObj = ["gameid": gameid,
        "active": false,
        "started": kFirebaseServerValueTimestamp];
    gameRef.child(gameid).set(gameObj);
    
}

func joinGame(uid: NSString as String,
    gameid: String) {
        var ref = new1 Firebase("https://vivid-torch-6580.firebaseio.com/");
        usersRef = ref.childByAppendingPath("Users");
        var userObj = ["gameid": gameid,
            "status": 1]
        usersRef.child(uid).update(userObj)
}

func addUser(uid: NSString as String,
    name: NSString as String,
    photo: String,
    dead: bool,
    targid: String,) -> Bool {
        var ref = new Firebase("https://vivid-torch-6580.firebaseio.com/");
        usersRef = ref.childByAppendingPath("Users");
        var userObj = ["uid": uid,
            "name": name,
            "photo": photo,
            "dead": false,
            "targid": targid];
        usersRef.child(uid).set(userObj);
}

//START

func startGame(gameid: String) {
    var ref = new Firebase("https://vivid-torch-6580.firebaseio.com/");
    gameRef = ref.childByAppendingPath("Games");
    usersRef = ref.childByAppendingPath("Users")
    var gameObj = ["gameid": gameid,
        "active": true,
    ]
    gameRef.child(gameid).update(gameObj);
    
}

func killTarget(uid: NSString as String) {
    
}