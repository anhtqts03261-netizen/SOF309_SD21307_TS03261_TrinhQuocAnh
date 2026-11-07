package entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Customers")
public class Customer implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerID")
    private Integer customerId;

    @Column(name = "Phone", unique = true, nullable = false, length = 15)
    private String phone;

    @Column(name = "Password", nullable = false, length = 256)
    private String password;

    @Column(name = "FullName", nullable = false, length = 100)
    private String fullName;

    @Column(name = "Email", unique = true, length = 100)
    private String email;

    @Column(name = "Rank", length = 20)
    private String rank = "BRONZE"; // 'BRONZE', 'SILVER', 'GOLD', 'DIAMOND'

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CreatedDate")
    private Date createdDate = new Date();
    
    @Column(name = "IsMember")
    private Boolean isMember = false;
    
    @Column(name="IsActive")
    private Boolean isActive=true;
    
    @Column(name = "TotalSpent")
    private Double totalSpent = 0.0;
    
    @Column(name = "RewardPoints")
    private Integer rewardPoints = 0;
    
    @Column(name="Avatar")
    private String avatar;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	// --- Constructors ---
    public Customer() {}

    // --- Getters and Setters ---
    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRank() { return rank; }
    public void setRank(String rank) { this.rank = rank; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    
    public Boolean getIsMember() {return isMember;}
    public void setIsMember(Boolean isMember) {this.isMember = isMember;}

	public Boolean getIsActive() {return isActive;}
	public void setIsActive(Boolean isActive) {this.isActive = isActive;}

	public Double getTotalSpent() {return totalSpent;}
	public void setTotalSpent(Double totalSpent) {this.totalSpent = totalSpent;}

	public Integer getRewardPoints() {return rewardPoints;	}
	public void setRewardPoints(Integer rewardPoints) {this.rewardPoints = rewardPoints;}

	public String getAvatar() {return avatar;}
	public void setAvatar(String avatar) {this.avatar = avatar;}
}