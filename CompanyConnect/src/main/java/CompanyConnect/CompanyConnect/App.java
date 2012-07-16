package CompanyConnect.CompanyConnect;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.management.relation.Relation;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * Hello world!
 *
 */
public class App 
{
	private ProfileData fetchData;
	 
	private void fetchLinkedInData(String[] data) throws IOException{
		fetchData = new ProfileData();
		
		Document doc = Jsoup.connect(data[4]).get();
        String title = doc.title();
        System.out.println( "Title of Page "+title);
        
        //Personal Information
        System.out.println("\nPersonal Information:\n");
        Elements content = doc.select(".profile-header #member-1");
        
        for (Element org : content) {
        	Personal temp = new Personal();
        	temp.setFirstName(org.select("span.given-name").text());
        	
        		temp.setLastName(org.select("span.family-name").text());
        		temp.setLocation(org.select("span.locality").text());
        		temp.setPhotoURL(org.select("img.photo").attr("src"));
        		temp.setEmailId(data[0]);
        		temp.setMobileNumber(data[3]);
        		temp.setConnections(Integer.parseInt(data[2]));
        		temp.setLinkedInURL(data[4]);
        		fetchData.setPersonalDetails(temp);
        		fetchData.setPersonalDetails(save(fetchData.getPersonalDetails()));
        	  System.out.println(org.select("span.given-name").text()+" "+org.select("span.family-name").text()+" "+org.select("span.locality").text());
        	  System.out.println(fetchData.getPersonalDetails().getPhotoURL());
        	  
        	}
        
        //Educational Information
        System.out.println("\nEducation Information:\n");
        content = doc.select("#profile-education .position");
        
        for (Element org : content) {
        	EducationDetails temp = new EducationDetails();
        	temp.setId(fetchData.getPersonalDetails().getId());
        	temp.setInstitute(org.select("h3.org").text());
        	temp.setDegree(org.select("span.degree").text());
        	temp.setMajor(org.select("span.major").text());
        	fetchData.getEduDetails().add(temp);
        	temp = save(temp);
        	  System.out.println(org.select("h3.org").text()+" "+org.select("span.degree").text()+" "+org.select("span.major").text());
        	}
        //Past Work Experience
        System.out.println("\nProfessional Information:\n");

        content = doc.select("#profile-experience .position");
        String[] startDate,endDate;
        int months;
        for (Element org : content) {

        	ProfessionalDetails temp = new ProfessionalDetails();
        	startDate=	org.select(".period .dtstart").attr("title").split("-");
        	endDate=	org.select(".period .dtend,.period .dtstamp").attr("title").split("-");
        	months=monthsBetweenDates(startDate, endDate);
        	System.out.println(org.select(".title").text()+" "+org.select("span.org").text()+" Duration: "+months);

        	temp.setId(fetchData.getPersonalDetails().getId());

        	temp.setDuration(months);
        	temp.setPosition(org.select(".title").text());
        	temp.setOrganization(org.select("span.org").text());
        	fetchData.getProfessionalDetails().add(temp);
        	temp = save(temp);
        	//System.out.println(org.select(".title").text()+" "+org.select("span.org").text()+" Duration: "+months);
        	}
        
      //Skills
        System.out.println("\nSkills Information:\n");

        content = doc.select("#profile-skills .jellybean");
        
        for (Element org : content) {
        	Skill temp = new Skill();
        	temp.setId(fetchData.getPersonalDetails().getId());
        	temp.setSkill(org.text());
        	fetchData.getSkills().add(temp);
        	temp = save(temp);
        	  System.out.println(org.text());
        	}


	}
	
	public static void fetchDetails() {
		try {
			System.out.println("In print me");
			String pathToCSVFile = "CitrixSocialBookData.csv";
			InputStream inputStream = App.class.getResourceAsStream(pathToCSVFile);
			BufferedReader CSVFile = new BufferedReader(new InputStreamReader(inputStream));
			String line = CSVFile.readLine();
			App obj = new App();
	        
			while (line != null) {
				String[] dataArray = line.split(",");
				String profile = dataArray[4];
				System.out.println(profile);
				obj.fetchLinkedInData(dataArray);
				line = CSVFile.readLine();

			}
			CSVFile.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println("\nException array index out of bound");
		}
	}
	
    public static void main( String[] args ) throws IOException
    {
    	fetchDetails();
        
        
    }
    static int monthsBetweenDates(String[] startDate, String[] endDate){
    	//System.out.println(startDate[0]+" "+startDate[1]+" "+startDate[2]);
    	//System.out.println(endDate[0]+" "+endDate[1]+" "+endDate[2]);
    	int months=(Integer.parseInt(endDate[0])-Integer.parseInt(startDate[0]))*12;
    	if(startDate.length<2) return months;
    	months+=Integer.parseInt(endDate[1])-Integer.parseInt(startDate[1]);
    	if(Integer.parseInt(startDate[2])> Integer.parseInt(endDate[2])) months--;
    	return months;
    }
    private static Personal save(Personal person) {
        SessionFactory sf = HibernateUtil.getSessionFactory();
        Session session = sf.openSession();
        session.beginTransaction();
     
        int id = (Integer) session.save(person);
        person.setId(id);
             
        session.getTransaction().commit();
             
        session.close();
     
        return person;
    }
    private static EducationDetails save(EducationDetails eduDetails) {
        SessionFactory sf = HibernateUtil.getSessionFactory();
        Session session = sf.openSession();
        session.beginTransaction();
     
        int id = (Integer) session.save(eduDetails);
        eduDetails.setEducationId(id);
             
        session.getTransaction().commit();
             
        session.close();
     
        return eduDetails;
    }
    
    private static ProfessionalDetails save(ProfessionalDetails professionalDetails) {
        SessionFactory sf = HibernateUtil.getSessionFactory();
        Session session = sf.openSession();
        session.beginTransaction();
     
        int id = (Integer) session.save(professionalDetails);
        professionalDetails.setPositionId(id);
             
        session.getTransaction().commit();
             
        session.close();
     
        return professionalDetails;
    }
    
    private static Skill save(Skill skills) {
        SessionFactory sf = HibernateUtil.getSessionFactory();
        Session session = sf.openSession();
        session.beginTransaction();
     
        int id = (Integer) session.save(skills);
        skills.setSkillId(id);
             
        session.getTransaction().commit();
             
        session.close();
     
        return skills;
    }
}
