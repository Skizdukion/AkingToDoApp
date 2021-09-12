# To do list - Aking - Devera
  To be simplify, this project aim to schedule task base on the idea of project, you can use for both personal or team goal. 
## Table of contents
- [Feature](#feature)
- [Some notes](#notes)
- [Some bugs](#bugs)
- [Introduce videos](#videos)
- [About the author](#about)
## Feature <a name = "feature"></a>
### Authenticate
<b>I just implement log in, but no register. You could log in the app by email like sample@gmail.com, sample1@gmail.com, sample2@gmail.com,... with passoword: 123456. I would create register fuction if you request me to do so.</b> 
- Onboarding Page <br />
![alt text](https://drive.google.com/uc?export=view&id=1XOWZHh3op7DsOcOrzaDE_Y36N6uK5m_o)<br />
- Login Page<br />
![alt text](https://drive.google.com/uc?export=view&id=1vmik8jTo7CqHNSPnggkg6IH7D4VlB4cU)<br />
### Project
<b>The core idea of this app was manage, classify task to project. You couldn't create task without project, so keep in mind that the first thing you want to do in the app is initialize a project.</b>
You could create a project, change name of it or delete it. But in order to delete it, you must clear all the task which belong to the project.
- Project Page<br />
![alt text](https://drive.google.com/uc?export=view&id=1051bjZGtHuRSJqd85-xVmXKM20ThN2N8)<br />
### Task
<b>Task is the fundamental stuff in this project along with quick note and check list. You could interact with it in many different ways like create, change, and delete. For more information about this part you should check the videos.</b>
- Add New Task<br />
![alt text](https://drive.google.com/uc?export=view&id=1YzIgawMYmmLSA6qfB8sLDWYwgB3OMbyv)<br />
- View Task Page<br />
![alt text](https://drive.google.com/uc?export=view&id=11GkM0nMpFw_zv3Plq_O428Wb2k12Mbld)<br />
### Quick Note
<b>Quick note is quite simple to use, all you could do is create or delete it.</b>
- Add Note Page<br />
![alt text](https://drive.google.com/uc?export=view&id=1gyorypUmzjJRK3aVSfR6KsRyMBR41LAQ)<br />
- Quick Note Page<br />
![alt text](https://drive.google.com/uc?export=view&id=1H9-GLZ-f8Q1rOG6cNrMH9UA36v2gcYYM)<br />
### Check List
<b>Check list just like quick note expcept it contains many list that can be mark as done or undone.</b>
- Add Check List Page<br />
![alt text](https://drive.google.com/uc?export=view&id=1xqvZBFH1FZpaIrXzRluBTaj7yRq-SO6W)<br />
### User Profile
<b>You could see all your statictis at here. More over, you could change your name or your avatar base on url image from the internet.</b>
- Profile Page<br />
![alt text](https://drive.google.com/uc?export=view&id=1qw9PTtpV-mUgx6k-ZX63ssc6pJKUIrNg)<br />
## Database
<b>This project was created with firebase. I mostly use stream & streamBuilder becasue it's convenient and could sync data with flutter in a mere secconds.</b>
- User Data DB<br />
![alt text](https://drive.google.com/uc?export=view&id=154NPcCO0_l46fHoArPR9lo3HFEjalLPh)<br />
- Project DB<br />
![alt text](https://drive.google.com/uc?export=view&id=1kBtVEdVNLCPyS9cEjtsZzyHp6WxqlYB6)<br />
- Task DB<br />
![alt text](https://drive.google.com/uc?export=view&id=17aSTPUwdUqg6MNbw3aZC_77R51C5kLmD)<br />
- Quick Note DB<br />
![alt text](https://drive.google.com/uc?export=view&id=1Gt6fxFE6M76zMJ1fWBuBqR22qcYAJO_y)<br />
## Some notes <a name = "notes"></a>
- This project was used for learning purpose. The UI i create was base on Devera Academy design team.
- I was not implemented any animation use for onboarding scene, so it stay at the same color and sometimes get bugs for different phone size becasue it's an image :)) I would fix this in near future if i could learn how to use animation.
- About the routing. I was create bloc and ui before i implement routing services so i just navigate screen back and forth through Navigator.push, Navigator.pop. However i could create routing services if i have more time because there are plenty of bug of bloc if i use Navigator.pushNamed instead of Navigator.push.
## Some bugs <a name = "bugs"></a>
- There are some bugs about the display of project's total task numbers when you use change tag in task.
- The ui was original create in 1080:2240 with 440 dpi. I just test it could work on many different size like: 900x1600, 320 dpi. However, it still get overflowed with size like: 720x1280 with 320dpi. I could fix this if i with screen utils package later on.
- I will fix these bugs and build splash and oboarding screen as soon as possible
## Introduce videos and file apk release <a name = "videos"></a>
[Drive Link](https://drive.google.com/drive/folders/1Zu3mayz9B3f-dgkc_Bi7XKL2y7MjtwxY?usp=sharing)
## About the author <a name = "about"></a>
### Contact me 
- Email: rider993sinus@gmail.com 
- Phone numbers: 0982481842
- Facebook: https://www.facebook.com/laidsdq/
