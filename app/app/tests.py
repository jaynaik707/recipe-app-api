from django.test import SimpleTestCase, TestCase

from app import calc


# class CalcTests2(SimpleTestCase):
#     """Test suite for the calc module."""

#     def test_add(self):
#         """Test addition."""
#         self.assertEqual(calc.add(2, 3), 5)
#         self.assertEqual(calc.add(-1, 1), 0)
#         self.assertEqual(calc.add(0, 0), 0)

# class CalcTests2(TestCase):
#     """Test suite for the calc module."""

#     def test_subtract(self):
#         """Test subtraction."""
#         self.assertEqual(calc.subtract(2, 3), -1)
#         self.assertEqual(calc.subtract(-1, 1), -2)
#         self.assertEqual(calc.subtract(0, 0), 0)