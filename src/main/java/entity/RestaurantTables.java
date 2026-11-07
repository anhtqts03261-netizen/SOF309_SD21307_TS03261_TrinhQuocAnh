package entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "RestaurantTables")
public class RestaurantTables implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TableID")
    private Integer tableId;

    @Column(name = "TableName", nullable = false, length = 50)
    private String tableName;

    @Column(name = "Capacity")
    private Integer capacity;

    @Column(name = "Position")
    private String position;

    @Column(name = "Status", length = 20)
    private String status = "EMPTY";

    @Column(name = "QRCode")
    private String qrCode;

    @Column(name = "IsActive")
    private Boolean isActive = true;
    
    @Column(name = "MergedWith")
    private Integer mergedWith;

    public RestaurantTables() {
    }

    public Integer getTableId() {
        return tableId;
    }

    public void setTableId(Integer tableId) {
        this.tableId = tableId;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

	public Integer getMergedWith() {
		return mergedWith;
	}

	public void setMergedWith(Integer mergedWith) {
		this.mergedWith = mergedWith;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
    
    

}