# Generated by Django 2.1.15 on 2021-09-03 06:51

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_auto_20210903_0650'),
    ]

    operations = [
        migrations.RenameField(
            model_name='recipe',
            old_name='time_minute',
            new_name='time_minutes',
        ),
    ]
