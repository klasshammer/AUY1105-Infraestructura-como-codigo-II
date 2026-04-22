/*
Diseña un módulo nuevo llamado s3_module que permita crear un bucket de Amazon S3 con las siguientes características:

Nombre único basado en un prefijo y un sufijo que defines en las variables del módulo.
Habilitación del versionado de objetos.
Reglas de acceso que permitan acceso público de solo lectura a los archivos.
Agrega el módulo al archivo principal de Terraform y configúralo con tus propias variables.
*/
resource "aws_s3_bucket" "ejemplo_bucket01" {
  bucket = "${var.bucket_prefix}-${var.bucket_suffix}"
}

# Habilitar versionado
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.ejemplo_bucket01.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Deshabilitar bloqueo de acceso público (necesario para lectura pública)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.ejemplo_bucket01.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política de solo lectura pública
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.ejemplo_bucket01.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.ejemplo_bucket01.arn}/*"
      },
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}
