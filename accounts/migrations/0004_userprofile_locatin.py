# Generated by Django 5.1.1 on 2024-11-14 03:38

import django.contrib.gis.db.models.fields
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_alter_userprofile_address'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='locatin',
            field=django.contrib.gis.db.models.fields.PointField(blank=True, null=True, srid=4326),
        ),
    ]
