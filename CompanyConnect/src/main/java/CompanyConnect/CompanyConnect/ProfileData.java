package CompanyConnect.CompanyConnect;

import java.util.ArrayList;
import java.util.List;

public class ProfileData {
	//LinkedIn URL
	private String linkedInURL;
	//Personal Information
	private String firstName, lastName, location, photoURL;
	
	private Personal personalDetails;
	//Educational Information
	private ArrayList<EducationDetails> eduDetails;
	//Professional Information
	private ArrayList<ProfessionalDetails> professionalDetails;
	//Skills
	private ArrayList<Skill> skills;
	
	public ProfileData(){
		eduDetails = new ArrayList<EducationDetails>();
		professionalDetails = new ArrayList<ProfessionalDetails>();
		skills = new ArrayList<Skill>();
		personalDetails = new Personal();
	}
	


	public String getLinkedInURL() {
		return linkedInURL;
	}
	public void setLinkedInURL(String linkedInURL) {
		this.linkedInURL = linkedInURL;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getPhotoURL() {
		return photoURL;
	}
	public void setPhotoURL(String photoURL) {
		this.photoURL = photoURL;
	}
	
	public Personal getPersonalDetails() {
		return personalDetails;
	}


	public void setPersonalDetails(Personal personalDetails) {
		this.personalDetails = personalDetails;
	}


	public ArrayList<EducationDetails> getEduDetails() {
		return eduDetails;
	}
	public void setEduDetails(ArrayList<EducationDetails> eduDetails) {
		this.eduDetails= eduDetails;
	}
	public ArrayList<ProfessionalDetails> getProfessionalDetails() {
		return professionalDetails;
	}
	public void setProfessionalDetails(ArrayList<ProfessionalDetails> professionalDetails) {
		this.professionalDetails = professionalDetails;
	}
	public ArrayList<Skill> getSkills() {
		return skills;
	}
	public void setSkills(ArrayList<Skill> skills) {
		this.skills = skills;
	}
	
	
	
}
