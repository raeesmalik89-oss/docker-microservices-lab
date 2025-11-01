
#!/bin/bash
echo "Creating microservices structure..."

# Create main directories
mkdir -p {user-service,product-service,order-service,api-gateway,nginx-lb,docker-compose-files}

# Create basic Dockerfile in each service
for service in user-service product-service order-service api-gateway; do
  cat > $service/Dockerfile << EOF
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
EOF
done

# Create nginx Dockerfile
cat > nginx-lb/Dockerfile << EOF
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
EOF

echo "Structure created successfully!"
