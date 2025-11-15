"""
Test for Django admin modification
"""

from django.test  import TestCase, Client
from django.contrib.auth import get_user_model 
from django.urls import reverse

class AdminSiteTests(TestCase):
    """Tests for Django admin"""

    def setUp(self):
        """"Create and user a client"""
        self.client = Client()
        self.admin_user = get_user_model().objects.create_superuser(
            email="admin@example.com",
            password="testpass"
        )
        self.client.force_login(self.admin_user)
        self.user =  get_user_model().objects.create_user(
            email="user@example.com",
            password="testpass",
            name = "Test User"
        )

    def test_user_listed(self):
        """Test that users are listed on the user page"""
        url = reverse("admin:core_user_changelist")
        res = self.client.get(url)

        self.assertContains(res, self.user.email)
        self.assertContains(res, self.user.name)