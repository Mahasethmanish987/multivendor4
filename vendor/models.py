from django.db import models
from accounts.models import User,UserProfile
from accounts.utils import send_notification
from datetime import time ,datetime,date

# Create your models here.
class Vendor(models.Model):
    user=models.OneToOneField(User,on_delete=models.CASCADE)
    user_profile=models.OneToOneField(UserProfile,related_name='user_profile',on_delete=models.CASCADE)
    vendor_name=models.CharField(max_length=50)
    vendor_license=models.ImageField(upload_to='vendor/license')
    vendor_slug=models.SlugField(max_length=100,blank=True)
    is_approved=models.BooleanField(default=False)
    created_at=models.DateTimeField(auto_now_add=True)
    modified_at=models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.vendor_name 
    
    def is_open(self):
         today_date=date.today()
         today=today_date.isoweekday()
         now=datetime.now()
         current_time=now.strftime("%H:%M:%S")
         
         current_opening_hours=OpeningHour.objects.filter(vendor=self,day=today)
         is_open=False 
         for hour in current_opening_hours:
               from_hour = hour.from_hour.replace('AM', ' AM').replace('PM', ' PM')
               to_hour = hour.to_hour.replace('AM', ' AM').replace('PM', ' PM')
              
               start=str(datetime.strptime(from_hour,'%I:%M %p').time())
               end=str(datetime.strptime(to_hour,'%I:%M %p').time())

               if current_time > start and current_time < end:
                   is_open=True 
                   break 
         return is_open 
              
         
         
    
    def save(self,*args,**kwargs):
         
        if not self.vendor_slug:
              self.vendor_slug=f"{self.vendor_name}-{self.user.id}"
              
        if self.pk is not None:
            orig=Vendor.objects.get(pk=self.pk)
            if orig.is_approved!=self.is_approved:
                mail_template='vendor/admin_approval.html'

                context={
                    'user':self.user,
                    'is_approved':self.is_approved
                }
                if self.is_approved==True:
                    mail_subject='Congratulations Your menu has been registered'

                    send_notification(mail_subject,mail_template,context)
                else:
                    mail_subject='Sorry! you are not eligible for publishing your menu'    
                    send_notification(mail_subject,mail_template,context)

        return super(Vendor,self).save(*args,**kwargs)         

HOUR_OF_DAY_24=[(time(h,m).strftime('%I:%M%p'),time(h,m).strftime('%I:%M%p')) for h in range(0,24) for m in (0,30)]
class OpeningHour(models.Model):
           DAYS=[
                (1,('Monday')),
                (2,('Tuesday')),
                (3,('Wednesday')),
                (4,('Thursday')),
                (5,('Friday')),
                (6,('Saturday')),
                (7,('Sunday')),
           ]
           vendor=models.ForeignKey(Vendor,on_delete=models.CASCADE)
           day=models.IntegerField(choices=DAYS)
           from_hour=models.CharField(choices=HOUR_OF_DAY_24,max_length=10,blank=True)
           to_hour=models.CharField(choices=HOUR_OF_DAY_24,max_length=10,blank=True)
           is_closed=models.BooleanField(default=False)

           class Meta:
                ordering=('day','from_hour')
                unique_together=('vendor','day','from_hour','to_hour')
           def __str__(self):
                return self.get_day_display()      

           


