import Alamofire

func checkUserExists(userToken: String) -> Bool {
	let url = "" //INSERT ENDPOINT URL HERE
	let param = ["userToken" : userToken]
	Alamofire.request(url, method: .get, headers: param, encoding: JSONEncoding.default).responseJSON { response in
			guard response.result.isSuccess else {
				return false
			}
			return true
	}
}

func putUserInDB(userToken: String, email: String, location: Int, accuracy: Float) -> Bool {
	let url = "" //INSERT ENDPOINT URL HERE
	param: ["email" : email, "authID": userToken, "location" : location, "accuracy" : accuracy]
	Alamofire.request(url, method: .post, headers: param, encoding: JSONEncoding.default).responseJSON { response in
			guard response.result.isSuccess else {
				return false
			}
			return true
	}

}