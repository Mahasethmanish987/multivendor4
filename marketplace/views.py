from django.shortcuts import render,get_object_or_404
from vendor.models import Vendor
from menu.models import Category,FoodItem
from django.db.models import Prefetch
from django.http import HttpResponse,JsonResponse
from .context_processor import get_cart_counter,get_cart_amounts
from .models import  Cart
from django.contrib.auth.decorators import login_required

# Create your views here.

def marketplace(request):
    vendors=Vendor.objects.filter(is_approved=True,user__is_active=True)
    vendor_count=vendors.count()
    context={
        'vendors':vendors,
        'vendor_count':vendor_count
    }
    return render(request,'marketplace/listing.html',context)


def vendor_detail(request,vendor_slug):
    vendor_instance=get_object_or_404(Vendor,vendor_slug=vendor_slug)
    categories=Category.objects.filter(vendor=vendor_instance).prefetch_related(
        Prefetch('fooditems',queryset=FoodItem.objects.filter(is_available=True))
        
    )
    if request.user.is_authenticated:
        cart_items=Cart.objects.filter(user=request.user)
    else:
        cart_items=None    

    context={
        'Vendor':vendor_instance,
        'categories':categories,
        'cart_items':cart_items
        
    }
    return render(request,'marketplace/vendor_detail.html',context)


def add_to_cart(request,food_id):
    if request.user.is_authenticated:
        if  request.headers.get('x-requested-with') == 'XMLHttpRequest':
            try:
                fooditem=FoodItem.objects.get(id=food_id)
                try:
                    chkcart=Cart.objects.get(user=request.user,fooditem=fooditem)
                    chkcart.quantity +=1
                    chkcart.save()
                    return JsonResponse({'status':'success','message':'increase the cart quantity','cart_counter':get_cart_counter(request),'qty':chkcart.quantity,'cart_amount':get_cart_amounts(request)})
                
                except:
                    chkcart=Cart.objects.create(user=request.user,fooditem=fooditem,quantity=1)
                    return JsonResponse({'status':'success','message':'cart added','cart_counter':get_cart_counter(request),'qty':chkcart.quantity,'cart_amount':get_cart_amounts(request)})


            except:
                return JsonResponse({'status':'failed','message':'food item does not exist'})    
        else:
            return JsonResponse({'status':'failed','message':'invalid request'})
    else:
        return JsonResponse({'status':'login_required','message':'please login to continue'})
    

def decrease_cart(request,food_id):
      
      if request.user.is_authenticated:
          if  request.headers.get('x-requested-with') == 'XMLHttpRequest':
              try:
                  fooditem=FoodItem.objects.get(id=food_id)
                  try:
                      
                      chkcart=Cart.objects.get(user=request.user,fooditem=fooditem)
                      
                      if chkcart.quantity > 1:
                          chkcart.quantity-=1
                          chkcart.save()
                      else:
                          chkcart.delete()
                          chkcart.quantity=0
                      
                      return JsonResponse({'status':'success','message':'Cart items increase','cart_counter':get_cart_counter(request),'qty':chkcart.quantity,'cart_amount':get_cart_amounts(request)})
                                           
                  except:
                      return JsonResponse({'status':'failed','message':'invalid request'})
                  
              except:
                  return JsonResponse({'status':'failed','message':'invalid request'})
                     
          else:
              return JsonResponse({'status':'failed','message':'invalid request'})
                  
          
      else:
          return JsonResponse({'status':'login_required','message':'invalid request'})
      

@login_required(login_url='accounts:login')
def cart(request):
    cart_items=Cart.objects.filter(user=request.user).order_by('created_at')
    context={
        'cart_items':cart_items
    }
    return render(request,'marketplace/cart.html',context)     

def delete_cart(request,id):
    if request.user.is_authenticated:
        if  request.headers.get('x-requested-with') == 'XMLHttpRequest':
            try:
                
                cart_item=Cart.objects.get(user=request.user,id=id)
                if cart_item:
                    cart_item.delete()
                    return JsonResponse({'status':'Success','message':'Item deleted successfully','cart_counter':get_cart_counter(request),'cart_amount':get_cart_amounts(request)})
            except:
                return JsonResponse({'status':'Failed','message':'cartitems does not exist'})
                


            
        else:
            return JsonResponse({'status':'Failed','message':'invalid request'})        






