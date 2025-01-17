#!/bin/bash
# Copyright 2019 The gRPC Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

# change to grpc repo root
cd $(dirname $0)/..

export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

# Install dotnet SDK
sudo apt-get install -y jq
./build/get-dotnet.sh
source ./activate.sh

mkdir -p artifacts

build/expand_dev_version.sh

(cd src/Grpc.AspNetCore.Server && dotnet pack --configuration Release --output ../../artifacts)
(cd src/Grpc.AspNetCore.Server.ClientFactory && dotnet pack --configuration Release --output ../../artifacts)
(cd src/Grpc.Net.Client && dotnet pack --configuration Release --output ../../artifacts)
(cd src/Grpc.Net.ClientFactory && dotnet pack --configuration Release --output ../../artifacts)
(cd src/Grpc.AspNetCore && dotnet pack --configuration Release --output ../../artifacts)
(cd src/dotnet-grpc && dotnet pack --configuration Release --output ../../artifacts)
