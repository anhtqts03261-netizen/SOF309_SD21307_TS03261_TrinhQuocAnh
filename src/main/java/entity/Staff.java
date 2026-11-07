package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Users") // Trỏ thẳng vào bảng Users
public class Staff {
    @Id
    @Column(name = "Username") // Username làm khóa chính
    private String id; // Bạn có thể giữ tên biến là id hoặc đổi thành username
    
    @Column(name = "FullName")
    private String name;
    
    @Column(name = "Phone")
    private String phone;
    
    @Column(name = "Role")
    private String position;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
    
    
}