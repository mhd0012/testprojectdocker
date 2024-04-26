# استفاده از تصویر پایتون به عنوان پایه
FROM python:3.10

# تنظیم کار دایرکتوری به /code
WORKDIR /code

# کپی کردن فایل‌های requirements.txt به داخل کانتینر
COPY requirements.txt /code/

# نصب وابستگی‌های پروژه
RUN pip install --no-cache-dir -r requirements.txt

# کپی کردن تمام فایل‌ها به داخل کانتینر
COPY . /code/

# اجرای دستورات مدیریتی جنگو برای ایجاد دیتابیس و جمع‌آوری فایل‌های استاتیک
RUN python manage.py migrate
RUN python manage.py collectstatic --noinput

# اجرای سرور توسعه دیجانگو
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
