import 'package:flutter/material.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 4, 51),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 34, 146),
        title: Text("Privacy And Policy"),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: RichText(
                text: TextSpan(children: const [
                  TextSpan(
                      text: "Privacy Policy ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 
                  

 Gokul K S built the Raaga 1.0.0 app as a Free app. This SERVICE is provided by Gokul K S at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Raaga 1.0.0 unless otherwise defined in this Privacy Policy. 




"""),
                  TextSpan(
                      text: "Information Collection and Use ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 


For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Packapeer Acadamy(Brototype),Infopark,kochi. The information that I request will be retained on your device and is not collected by me in any way.

The app does use third-party services that may collect information used to identify you.

Link to the privacy policy of third-party service providers used by the app.


"""),
                  TextSpan(text: """
• Google Play Services
• Google Analytics for Firebase
• Unity
• SDKBOX
• Sentry
• Mapbox




 """, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  TextSpan(
                      text: "Log Data",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 

              
I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.




 """),
                  TextSpan(
                    text: "Cookies",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextSpan(text: """ 


Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.




 """),
                  TextSpan(
                      text: "Service Providers",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(
                    text: """ 


I may employ third-party companies and individuals due to the following reasons:

""",
                  ),
                  TextSpan(text: """ 
• To facilitate our Service;
• To provide the Service on our behalf;
• To perform Service-related services; or
• To assist us in analyzing how our Service is used.

""", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: """ 
I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.
 



 """,
                  ),
                  TextSpan(
                      text: "Security",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 


I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.



 """),
                  TextSpan(
                      text: "Links to Other Sites",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 


This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.



 """),
                  TextSpan(
                      text: "Children’s Privacy",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 


These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.



 """),
                  TextSpan(
                      text: "Changes to This Privacy Policy",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 


I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2025-12-31



 """),
                  TextSpan(
                      text: "Contact Us",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: """ 


If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at gokulksureshekd5606@gmail.com.


 """),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
