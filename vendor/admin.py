from django.contrib import admin
from .models import Vendor 
from django.utils.text import slugify 


# Register your models here.
class VendorAdmin(admin.ModelAdmin):
    list_display=('user','vendor_name','is_approved','created_at')
    list_display_links=('user','vendor_name')
    list_editable=('is_approved',)
    prepopulated_fields = {'vendor_slug': ('vendor_name',)}
    
    

    # def save_model(self,request,obj,form,change):
    #     if not obj.vendor_slug:
    #         obj.vendor_slug=slugify(f'{obj.vendor_name}-{obj.user.id}')
    #         super().save_model(request,obj,form,change)

     

admin.site.register(Vendor,VendorAdmin)
