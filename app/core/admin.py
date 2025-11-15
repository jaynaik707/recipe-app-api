from django.contrib import admin  
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from core import models

# Register your models here.

class UserAdmin(BaseUserAdmin):
    """Define the admin model for the user."""
    list_display = ('email', 'name', 'is_active', 'is_staff')
    ordering = ('id',)


admin.site.register(models.User, UserAdmin)