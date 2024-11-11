from django.contrib import admin
from .models import User,UserProfile
from django.contrib.auth.admin import UserAdmin

# Register your models here.
class CustomUserAdmin(UserAdmin):
   filter_horizontal=()
   list_filter=()
   fieldsets=()

   list_display=('email','first_name','last_name','username','role','is_active','date_joined','modified_at')
   ordering=('date_joined',)
   readonly_fields=('role',)
   list_editable=('is_active',)
    
admin.site.register(User,CustomUserAdmin)
admin.site.register(UserProfile)