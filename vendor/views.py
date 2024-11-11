from django.shortcuts import render,redirect,get_object_or_404
from .forms import VendorForm
from accounts.forms import registerUser
from accounts.models import User,UserProfile
from .models import Vendor 
from django.template.defaultfilters import slugify
from django.contrib import messages 
from accounts.utils import send_verification_email
from django.contrib.auth.decorators import login_required,user_passes_test
from accounts.views import check_vendor
from accounts.forms import UserProfileForm
from .forms import VendorForm
from menu.models import Category,FoodItem
from menu.forms import CategoryForm,FoodItemForm
# Create your views here.
def get_vendor(request):
    vendor=Vendor.objects.get(user=request.user)
    return vendor 

def registerVendor(request):
    if request.user.is_authenticated:
        messages.info(request,'You are already logged in ')
        return redirect('myapp:index')
    if request.method=='POST':
        form=registerUser(request.POST)
        v_form=VendorForm(request.POST,request.FILES)
        if form.is_valid and v_form.is_valid():
            username=request.POST['username']
            email=request.POST['email']
            first_name=request.POST['first_name']
            last_name=request.POST['last_name']
            phone_number=request.POST['phone_number']
            password=request.POST['password']
            user=User.objects.create_user(username=username,email=email,first_name=first_name,last_name=last_name,phone_number=phone_number,password=password)
            user.role=User.RESTAURANT
            user.save()
            mail_subject='please activate your account'
            mail_template='accounts/account_verification.html'
            send_verification_email(request,user,mail_subject,mail_template)
            vendor=v_form.save(commit=False)
            vendor.user=user 
            user_profile=UserProfile.objects.get(user=user)
            vendor.user_profile=user_profile
            vendor.vendor_slug=slugify(vendor.vendor_name)+'-'+str(user.id)
            vendor.save()
            messages.success(request,'vendor has registered successfully')
            return redirect('myapp:index')
            
        else:
            return render(request,'vendor/vendorRegistration.html',{'form':uform,'v_form':vform})


    else:
        uform=registerUser()
        vform=VendorForm()
        context={
            'form':uform,
            'v_form':vform,
        }
        return render(request,'vendor/vendorRegistration.html',context)
    
@login_required(login_url='accounts:login')
@user_passes_test(check_vendor)
def vprofile(request):
    vendor=get_object_or_404(Vendor,user=request.user)
    profile=get_object_or_404(UserProfile,user=request.user)
    if request.method=='POST':
        user_profile=UserProfileForm(request.POST,request.FILES,instance=profile)
        vendor_profile=VendorForm(request.POST,request.FILES,instance=vendor)
        if user_profile.is_valid() and vendor_profile.is_valid():
            user_profile.save()
            vendor_profile.save()
            messages.success(request,'settings updated')
            return redirect('vendor:vprofile')
        else:
            context={
                'user_profile':user_profile,
                'vendor_profile':vendor_profile,
                'vendor':vendor,
                'profile':profile
            }
            return render(request,'vendor/vprofile.html',context)
    else:
        user_profile=UserProfileForm(instance=profile)
        vendor_profile=VendorForm(instance=vendor)
        context={
            'user_profile':user_profile,
            'vendor_profile':vendor_profile,
            'vendor':vendor,
            'profile':profile 
        }

    return render(request,'vendor/vprofile.html',context)

@login_required(login_url='accounts:login')
@user_passes_test(check_vendor)
def menu_builder(request):
    vendor=get_vendor(request)
    categories=Category.objects.filter(vendor=vendor)
    context={
        'categories':categories
    }
    return render(request,'vendor/menu_builder.html',context)
@login_required(login_url='accounts:login')
@user_passes_test(check_vendor)
def add_category(request):

    if request.method=='POST':
        form=CategoryForm(request.POST)
        if form.is_valid():
            category=form.save(commit=False)
            category.vendor=get_vendor(request)
            category_name=form.cleaned_data['category_name']
            category.slug=slugify(category_name)
            category.save()
            messages.success(request,'Category Added')
            return redirect('vendor:menu_builder')
        else:    
            return render(request,'vendor/add_category.html',{'form':form})
    else:
        form=CategoryForm()
        context={
            'form':form
        }     
    

    return render(request,'vendor/add_category.html',context)
@login_required(login_url='accounts:login')
@user_passes_test(check_vendor)
def edit_category(request,pk):
    category=get_object_or_404(Category,pk=pk)

    if request.method=='POST':
        form=CategoryForm(request.POST,instance=category)
        if form.is_valid():
            category_name=form.cleaned_data['category_name']
            category=form.save(commit=False)
            category.vendor=get_vendor(request)
            category.slug=slugify(category_name)
            category.save()
            messages.success(request,'Your Category has been updated')
            return redirect('vendor:menu_builder')
             
        else:
            return render(request,'vendor/edit_category.html',{'form':form})
    else:
        form=CategoryForm(instance=category)

    return render(request,'vendor/edit_category.html',{'form':form})    
@login_required(login_url='accounts:login')
@user_passes_test(check_vendor)
def delete_category(request,pk):
    category=get_object_or_404(Category,pk=pk)
    category.delete()
    messages.success(request,'Category deleted')
    return redirect('vendor:menu_builder')


def food_items_by_category(request,pk):
    vendor=get_vendor(request)
    category=get_object_or_404(Category,pk=pk)
    fooditems=FoodItem.objects.filter(vendor=vendor,category=category)
    context={
        'fooditems':fooditems,
        'category':category
    }
    return render(request,'vendor/food_items_by_category.html',context)

def add_food(request):
    if request.method=='POST':
        form=FoodItemForm(request.POST,request.FILES)
        if form.is_valid():
            foodtitle=form.cleaned_data['food_title']
            food=form.save(commit=False)
            food.vendor=get_vendor(request)
            food.slug=slugify(foodtitle)
            food.save()
            messages.success(request,'Food items has updated succesfully')
            return redirect('vendor:food_items_by_category' ,food.category.id)
        else:
            return render(request,'vendor/add_food.html',{'form':form})
    else:
        
      form=FoodItemForm()
      form.fields['category'].queryset=Category.objects.filter(vendor=get_vendor(request))
    return render(request,'vendor/add_food.html',{'form':form})


def edit_food(request,pk):
    food=get_object_or_404(FoodItem,pk=pk)
    if request.method=='POST':
        form=FoodItemForm(request.POST,request.FILES,instance=food)
        if form.is_valid():
            foodtitle=form.cleaned_data['food_title']
            food1=form.save(commit=False)
            food1.vendor=get_vendor(request)
            food1.slug=slugify(foodtitle)
            food.save()
            messages.success(request,'Food items saved successfully')
            return redirect('vendor:food_items_by_category',food.category.id)
        else:
            return render(request,'vendor/edit_form.html',{'form':form,'food':food})
    else:
        form=FoodItemForm(instance=food)
    return render(request,'vendor/edit_food.html',{'form':form,'food':food})


def delete_food(request,pk):
    food=FoodItem.objects.get(pk=pk)
    food.delete()
    messages.success(request,'food items deleted successfuly')
    return redirect('vendor:food_items_by_category',food.category.id)
    
