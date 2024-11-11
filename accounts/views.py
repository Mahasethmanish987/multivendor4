from django.shortcuts import render,redirect
from .forms import registerUser
from .models import User ,UserProfile
from django.contrib import messages 
from django.contrib.auth import login , logout , authenticate 
from django.contrib.auth.decorators  import login_required,user_passes_test
from .utils import detectUser
from django.urls import reverse 
from django.core.exceptions import PermissionDenied
from django.utils.http import urlsafe_base64_decode 
from django.contrib.auth.tokens import default_token_generator
from .utils import send_verification_email
# Create your views here.
def check_customer(user):
    if user.role==2:
        return True 
    else:
        raise PermissionDenied 
def check_vendor(user):
    if user.role==1:
        return True
    else:
        raise PermissionDenied
        

def userRegistration(request):
    if request.user.is_authenticated:
        messages.info(request,'You are already LoggedIn')
        return redirect('myapp:index')
    
    if request.method=='POST':
        form=registerUser(request.POST)
        if form.is_valid():
            first_name=form.cleaned_data['first_name']
            last_name=form.cleaned_data['last_name']
            username=form.cleaned_data['username']
            email=form.cleaned_data['email']
            password=form.cleaned_data['password']
            phone_number=form.cleaned_data['phone_number']
            user=User.objects.create_user(first_name=first_name,last_name=last_name,username=username,email=email,phone_number=phone_number,password=password)
            user.role=User.CUSTOMER
            user.save()
            mail_subject='Please activate your account'
            mail_template='accounts/account_verification.html'
            send_verification_email(request,user,mail_subject,mail_template)

            messages.success(request,'User has registered successfully')
            return redirect('myapp:index')
        else:
            return render(request,'accounts/userRegistration.html',{'form':form})   
    else:
        form=registerUser()     

    return render(request,'accounts/userRegistration.html',{'form':form})

def login_view(request):
    if request.user.is_authenticated:
        messages.info(request,'You are already LoggedIn')
        return redirect('myapp:index')
    if request.method=='POST':
        email=request.POST['email']
        password=request.POST['password']
        user=authenticate(email=email,password=password)
        if user is not None:
            login(request,user)
            messages.success(request,'User has been successfully login')
            return redirect('myapp:index')
        else:
            messages.info(request,'Invalid Credentials')
            return render(request,'accounts/login.html')
        
    return render(request,'accounts/login.html')

def logout_view(request):
    logout(request)
    messages.info(request,'You have been successfully logout')
    return redirect('myapp:index')

@login_required(login_url='accounts:login')
def myAccount(request):
    user=request.user 
    redirectUrl=detectUser(user)
    if redirectUrl=='admin:index':
        return redirect(reverse(redirectUrl))
    else:
        return redirect(reverse(f'accounts:{redirectUrl}'))
    
@login_required(login_url='accounts:login')
@user_passes_test(check_vendor)
def vendorDashboard(request):
    return render(request,'vendor/vendorDashboard.html') 


@login_required(login_url='accounts:login')
@user_passes_test(check_customer)
def customerDashboard(request):
    user=request.user
    user_profile=UserProfile.objects.get(user=user)

    return render(request,'accounts/customerDashboard.html',{'user_profile':user_profile})


def activate(request,uidb64,token):
    try:
        uid=urlsafe_base64_decode(uidb64).decode()
        user=User.objects.get(pk=uid)
    except(TypeError,ValueError,OverflowError,User.DoesNotExist):
        user=None

    if user is not None and default_token_generator.check_token(user,token):
        user.is_active=True
        user.save()
        messages.success(request,'Congratulations You have been activated')
        return redirect('myapp:index')
    else:
        messages.error(request,'Invalid Link')    
        return redirect('myapp:index')
    
def forgot_password(request):
    if request.method=='POST':
        email=request.POST['email']
        if User.objects.filter(email=email).exists():
            user=User.objects.get(email=email)
            mail_subject='Reset Your Password'
            mail_template='accounts/reset_password_link.html'
            send_verification_email(request,user,mail_subject,mail_template)
            messages.success(request,'Password reset link send')
            return redirect('myapp:index')
        else:
            messages.error(request,'No such email found')
            return render(request,'accounts/forgot_password.html')
    else:
        return render(request,'accounts/forgot_password.html')   

def reset_password_validate(request,uidb64,token):
    try:
        uid=urlsafe_base64_decode(uidb64).decode()
        user=User.objects.get(pk=uid)
    except(TypeError,OverflowError,ValueError,User.DoesNotExist):
        user=None

    if user is not None and default_token_generator.check_token(user,token):
        request.session['uid']=uid
        messages.info(request,'please reset your password')
        return redirect('accounts:reset_password')
    
    else:
        messages.error(request,'these link has been expired')
        return redirect('accounts: forgot_password')

def reset_password(request):
    if request.method=='POST':
      password=request.POST['password']    
      confirm_password=request.POST['confirm_password']

      if password==confirm_password:
          pk=request.session.get('uid')
          if pk is  None:
              messages.error(request,'User not found')
              return redirect('accounts:forgot_password')
          try:
              user=User.objects.get(pk=pk)
          except User.DoesNotExist:
              messages.error(request,'User Not found')
              return redirect('accounts:forgot_password')
          user.set_password(password)
          user.is_active=True
          user.save()
          messages.success(request,'passwor reset successfully')
          return redirect('accounts:login')
      else:
          messages.error(request,'password and confirm_password does not match')
          return redirect('accounts:reset_password')
      

    else:
        return render(request,'accounts/reset_password.html')
                      
                  



        

       


