package entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Users")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "Username", length = 50)
    private String username;

    @Column(name = "Password", nullable = false, length = 256)
    private String password;

    @Column(name = "FullName", nullable = false, length = 100)
    private String fullName;

    @Column(name = "Email", unique = true, length = 100)
    private String email;

    @Column(name = "Phone", length = 15)
    private String phone;

    @Column(name = "Role", nullable = false, length = 20)
    private String role; // 'ADMIN', 'WAITER', 'CHEF', 'STOREKEEPER'

    @Column(name = "IsActive")
    private Boolean isActive = true;
    
    @Column(name = "Avatar", length = 255)
    private String avatar;


    // --- Constructors ---
    public User() {}

    public User(String username, String password, String fullName, String role) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
    }

    // --- Getters and Setters ---
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

	public String getAvatar() {return avatar;}
	public void setAvatar(String avatar) {this.avatar = avatar;}
	
	public static long getSerialversionuid() {return serialVersionUID;}
}