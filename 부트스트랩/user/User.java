package user;
public class User {
	

		//db와 동일한 형태로 넣기
		private String userID;
		private String userPassword;
		private String userName;
		private String userGender;
		private String userEmail;
		public String getUserID() {
			return userID;
		}
		public void setUserID(String userID) {
			this.userID = userID;
		}
		public String getUserPassword() {
			return userPassword;
		}
		public void setUserPassword(String userPassword) {
			this.userPassword = userPassword;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public String getUserGender() {
			return userGender;
		}
		public void setUserGender(String userGender) {
			this.userGender = userGender;
		}
		public String getUserEmail() {
			return userEmail;
		}
		public void setUserEmail(String userEmail) {
			this.userEmail = userEmail;
		}
		
		//jsp서버에서 쓸 수있게 getter setter를 쓴다.
		//자바빈즈..하나의 데이터를 관리하는걸 jsp에서 구현하는 것을 자바bins라고 한다.
		
	}


