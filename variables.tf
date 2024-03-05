# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
    default     = "us-east-1"
}

variable "eks_cluster_name" {
  default = "dev-eks"
}

variable "aws_region" {
  default = "us-east-1"
}
