import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Trie "mo:base/Trie";
import Array "mo:base/Array";
import List "mo:base/List";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

// import Debug "mo:base/Debug";
// import HTTP "http";

// import Time "mo:base/Time";

actor {
  public type Person = {
      FirstName : Text;
      LastName: Text;
      Birthday : Text;
      Phone : Text;
      Address: Text;
      Sex : Bool;
  };

  var next : Nat = 0;

  public type Data =  {
    person : Person;
    id : Nat;
  };
    
  // stable var entries : [( Principal, Person)] = [];

  stable var customers : Trie.Trie<Nat, Person> = Trie.empty();

  public func test_trie() : async [Data] {
    // next += 1;
    var person: Person = {
      FirstName = "asfds";
      LastName = "saaddas";
      Birthday = "asdasasd";
      Phone = "asdasdas";
      Address = "Asdas";
      Sex = true;
    };
    let (newPersons, existing) = Trie.put(
      customers,
      key(next),
      Nat.equal,
      person
    );

    customers := newPersons;
    
     var person2: Person = {
      FirstName = "1211323";
      LastName = "12312312";
      Birthday = "12323";
      Phone = "123123";
      Address = "As123123das";
      Sex = true;
    };

    let (newPersons2, existing2) = Trie.put(
      customers,
      key(next+1),
      Nat.equal,
      person2
    );
    customers := newPersons2;

    return Trie.toArray<Nat, Person, Data>(customers, func (id, val)  {
      {
        person = val;
        id = id;
      }
    });
  };
  
  private func key(x : Nat) : Trie.Key<Nat>{
    return{
      key = x;
      hash = Hash.hash(x);
    };
  };

  // type FavorResult = {#ok : Text; #dup : Text};
  // type FavorResult<T,E> = Result.Result<T, E>;

  // Function 1:  Read Account function
    
  // public query func read_Account(principal : Principal) : async Nat {
  //   let result = Array.from
  //   return result;
  // };

  // Function 2: Create Account
  public func createAccount ( FirstName : Text, LastName : Text, Birthday : Text, Phone : Text, Address: Text, Sex : Bool ) : async Bool {
    next += 1;
    var person: Person = {
      FirstName = FirstName;
      LastName = LastName;
      Birthday = Birthday;
      Phone = Phone;
      Address = Address;
      Sex = Sex;
    };
    let (newPersons, existing) = Trie.put(
      customers,
      key(next),
      Nat.equal,
      person
    );
    switch(existing) {
      // if there is no match
      case (null) {
         customers := newPersons;
      };
      // Match
      case(?v) {
        return false;
      };
    };
    return true;
  };

  // Function 3: Update Account function
  public func updateAccount ( id : Nat, FirstName : Text, LastName : Text, Birthday : Text, Phone : Text, Address: Text, Sex : Bool ) : async Bool {
    let result = Trie.find(
      customers,key(id),Nat.equal
    );
    switch(result) {
      // Not update
      case (null) {
        return false;
      };
      case (?v) {
        var person: Person = {
          FirstName = FirstName;
          LastName = LastName;
          Birthday = Birthday;
          Phone = Phone;
          Address = Address;
          Sex = Sex;
        };
        customers := Trie.replace(
          customers,key(id),Nat.equal,?person
        ).0;
      };  
    };
    return true;
  };

  //delete
  public shared(caller) func deleteAccount ( id : Nat ) : async Bool {
    let result = Trie.find(
      customers,key(id),Nat.equal
    );
    switch(result) {
      // Not update
      case (null) {
        return false;
      };
      case (?v) {
        customers := Trie.replace(
          customers,key(id),Nat.equal,null
        ).0;
      };  
    };
    return true;
  };
}