# Generated by Django 5.1 on 2024-11-16 03:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('vendor', '0003_openinghour'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='openinghour',
            unique_together={('vendor', 'day', 'from_hour', 'to_hour')},
        ),
    ]
