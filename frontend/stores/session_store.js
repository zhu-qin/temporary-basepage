const AppDispatcher = require('../dispatcher/dispatcher');
const SessionConstants = require('../constants/session_constants');
const Store = require('flux/utils').Store;

const SessionStore = new Store(AppDispatcher);

let _user = {};

let _signIn = function(user){
  _user = user;
};

let _signOut = function(){
  _user = {};
};

SessionStore.getCurrentUser = function(){
  return Object.assign({}, _user);
};

SessionStore.isSignedIn = function(){
  if (SessionStore.getCurrentUser().id){
    return true;
  }else {
    return false;
  }
};

SessionStore.__onDispatch = function(payload){
  switch (payload.actionType) {
    case SessionConstants.RECEIVE_USER:
    _signIn(payload.user);
    SessionStore.__emitChange();
    break;
    case SessionConstants.SIGN_OUT:
    _signOut();
    SessionStore.__emitChange();
    break;
  }
};

module.exports = SessionStore;
