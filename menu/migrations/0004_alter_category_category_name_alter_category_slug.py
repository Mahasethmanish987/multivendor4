# Generated by Django 5.1 on 2024-11-07 14:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('menu', '0003_fooditem_price'),
    ]

    operations = [
        migrations.AlterField(
            model_name='category',
            name='category_name',
            field=models.CharField(max_length=50),
        ),
        migrations.AlterField(
            model_name='category',
            name='slug',
            field=models.SlugField(max_length=100),
        ),
    ]
